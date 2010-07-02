From: p.osciak@samsung.com (Pawel Osciak)
Date: Fri, 02 Jul 2010 15:05:20 +0200
Subject: [PATCH v3 03/12] s3c-fb: Separate S5PC100 and S5PV210 framebuffer
	driver data structures
In-Reply-To: <4C2DC986.7040705@simtec.co.uk>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-4-git-send-email-p.osciak@samsung.com>
	<4C2DC986.7040705@simtec.co.uk>
Message-ID: <003d01cb19e7$39c7db50$ad5791f0$%osciak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Ben Dooks <ben@simtec.co.uk> wrote:
>On 28/06/10 09:08, Pawel Osciak wrote:
>> S5PC100 and S5PV210 framebuffer devices differ slightly in terms of
>> available registers and their driver data structures have to be separate.
>
>Would have been nice to note which ones changes, otherwise ok.

For this series, the difference is the existence of PRTCON and SHADOWCON
registers. There are more AFAIR. I am not sure if it'd be a good place
to list all of them though...

Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
