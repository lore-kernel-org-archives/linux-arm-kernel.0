From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 14 May 2011 05:32:24 +0200
Subject: your mail
In-Reply-To: <20110513193502.2BBAF40CD1@eskimo.mtv.corp.google.com>
References: <20110513193502.2BBAF40CD1@eskimo.mtv.corp.google.com>
Message-ID: <20110514033224.GA14136@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:35 Fri 13 May     , Vadim Bendebury wrote:
> >From 8ed0ea5fcf5552ca3307611b685b4518794eca41 Mon Sep 17 00:00:00 2001
> From: Vadim Bendebury <vbendeb@chromium.org>
> Date: Wed, 11 May 2011 17:31:40 -0700
> Subject: [PATCH 1/1] ARM: thumb: Have the machine name indicate operation in thumb mode.
> 
> This is a cosmetic change, adding a '_thumb' prefix to the
> 'Hardware' line in /proc/cpuinfo. Tested as follows:
I do think is the right place or right way to do so

I think we need to create a sysfs entry to allow machine to more information

Best Regards,
J.
