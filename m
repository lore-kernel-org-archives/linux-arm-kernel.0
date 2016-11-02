From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 02 Nov 2016 22:41:45 +0100
Subject: [PATCH 1/3] ARM: pxa: mioa701: use the new pxa_camera
 platform_data
In-Reply-To: <1474662654-23263-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Fri, 23 Sep 2016 22:30:52 +0200")
References: <1474662654-23263-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87twbpzhie.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> pxa_camera has transitioned from a soc_camera driver to a standalone
> v4l2 driver. Amend the device declaration accordingly.
Queued to pxa/for-next.

--
Robert
