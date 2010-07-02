From: ben@simtec.co.uk (Ben Dooks)
Date: Fri, 02 Jul 2010 12:12:06 +0100
Subject: [PATCH v3 03/12] s3c-fb: Separate S5PC100 and S5PV210 framebuffer
	driver data structures
In-Reply-To: <1277712538-23188-4-git-send-email-p.osciak@samsung.com>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-4-git-send-email-p.osciak@samsung.com>
Message-ID: <4C2DC986.7040705@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/06/10 09:08, Pawel Osciak wrote:
> S5PC100 and S5PV210 framebuffer devices differ slightly in terms of
> available registers and their driver data structures have to be separate.

Would have been nice to note which ones changes, otherwise ok.
