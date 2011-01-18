From: will.newton@gmail.com (Will Newton)
Date: Tue, 18 Jan 2011 10:21:23 +0000
Subject: [PATCH v4] dw_mmc: Add Synopsys DesignWare mmc host driver.
In-Reply-To: <4D354752.3030401@samsung.com>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
	<20101208115510.GD10998@console-pimps.org>
	<AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
	<AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
	<20101209064751.GA21128@void.printf.net>
	<AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
	<20101209160157.GA28586@void.printf.net>
	<AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com>
	<20101211192320.GA24430@void.printf.net>
	<AANLkTik7cMwgwXR1zK44HXC+1YtzpU3_zW2GUjcBMi8X@mail.gmail.com>
	<4D354752.3030401@samsung.com>
Message-ID: <AANLkTi=SEXYk9B6N6RGmLKAx_QF6sybgHMVVpEo8mcp8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 7:54 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Will.
>
> I have some question...i'm testing dw_mmc in our environment.
> but i didn't understand pdata->init(?)...what initialize in there?

In most of our platforms init is empty so I guess it would be fine to
change that code to ignore a null init pointer. An example of one of
the things we do use the init function for is to switch pins to GPIO
to handle card detect.
