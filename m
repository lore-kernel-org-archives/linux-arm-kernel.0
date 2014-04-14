From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 11:36:42 +0200
Subject: [PATCH 06/29] memory: mvebu-devbus: split functions
In-Reply-To: <1397400006-4315-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BAC2A.2040507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> The mvebu-devbus driver currently only supports the Armada 370/XP
> family, but it can also cover the Orion5x family. However, the Orion5x
> family has a different organization of the registers.
>
> Therefore, in preparation to the introduction of Orion5x support, we
> separate into two functions the code that 1/ retrieves the timing
> parameters from the Device Tree and 2/ applies those timings
> parameters into the hardware registers.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

If you change the formula in patch 4/29, the same applies here.

Reviewed-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
