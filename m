From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Feb 2011 19:49:57 +0900
Subject: [PATCH 01/09] ARM: s3c2442: gta02: Fix usage gpio bank j pin
	definitions
In-Reply-To: <4D6B7D19.1050103@metafoo.de>
References: <1297043521-21903-1-git-send-email-lars@metafoo.de>
	<000801cbd712$907019c0$b1504d40$%kim@samsung.com>
	<4D6B7D19.1050103@metafoo.de>
Message-ID: <003301cbd735$40353b20$c09fb160$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lars-Peter Clausen wrote:
> 
> On 02/28/2011 07:41 AM, Kukjin Kim wrote:
> > Lars-Peter Clausen wrote:

(snip)

> >
> > Yeah, old S3C2440_GPJx has removed.
> > Is the S3C2410_GPJ(1) right instead of S3C2440_GPJ1?
> 
> I think so. At least the the compile errors are gone and the drivers using
> these gpios work as expected.
> 
Ok, you mean test it on board...so will apply into my s5p-fixes-for-linus
for 38-rc.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
