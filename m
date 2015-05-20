From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 20 May 2015 06:53:50 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Add Atmel SAMA5 family
In-Reply-To: <555B4040.2090302@atmel.com>
References: <1428051678-20450-1-git-send-email-alexandre.belloni@free-electrons.com>
 <555AFF3F.10400@atmel.com> <9986808.t62JLgg5NJ@wuerfel>
 <20150519123358.GA15179@piout.net> <555B3463.2060700@atmel.com>
 <555B3A92.7010409@atmel.com> <555B4040.2090302@atmel.com>
Message-ID: <CAMAWPa95VTM+VgNpcs1oZwX9NqzrL1JeNy=MqL0Zo3JP=svyUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FYI... This patch is now in linux-next, and boot tests for all the
sama5d[34] boards in kernelci.org have failed to boot.

   http://kernelci.org/boot/all/job/next/kernel/next-20150520/

Kevin
