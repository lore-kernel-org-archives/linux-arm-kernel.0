From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 07 Oct 2013 23:47:55 +0200
Subject: [PATCH 0/5] Armada DRM stuff
In-Reply-To: <20131006220728.GG12758@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
Message-ID: <52532C0B.3090503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 12:07 AM, Russell King - ARM Linux wrote:
> The Armada DRM drivers again, along with the TDA998x HDMI output support,
> and an illustration to show how to add Armada 610 support (and others.)
>
> Rob has looked at this a couple of times since its last posting, and
> has provided additional useful feedback which has been incorporated.
> I believe all the major issues have been addressed now.

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

on Marvell Armada 510, SolidRun CuBox with quick-hack DT support added.

Let's please get this driver mainlined and start working on proper DT
support for it. Thanks for driver and the patience to work out all
issues!

Sebastian
