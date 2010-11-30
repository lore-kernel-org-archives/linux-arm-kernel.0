From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 30 Nov 2010 17:01:02 +0200
Subject: [PATCH RESEND v3] ARM: s3c2442: Setup gpio {set,
	get}_pull callbacks
In-Reply-To: <4CF50FD5.1090705@metafoo.de>
References: <000201cb8fae$4d61fd20$e825f760$%kim@samsung.com>
	<201011301633.05545.anarsoul@gmail.com>
	<4CF50FD5.1090705@metafoo.de>
Message-ID: <201011301701.03443.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 November 2010 16:53:09 Lars-Peter Clausen wrote:

> Both the cpu init code and the machine init code are run at arch_initcall.

Yeah, you're right.
