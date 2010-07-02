From: ben@simtec.co.uk (Ben Dooks)
Date: Fri, 02 Jul 2010 11:51:27 +0100
Subject: [PATCH v3 02/12] s3c-fb: Correct FRAMESEL1 bitfield defines for
	VIDINTCON0 register
In-Reply-To: <1277712538-23188-3-git-send-email-p.osciak@samsung.com>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-3-git-send-email-p.osciak@samsung.com>
Message-ID: <4C2DC4AF.7080906@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/06/10 09:08, Pawel Osciak wrote:
> FRAMESEL1 bitfield starts on 13th bit, not on 14th.
> 
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
