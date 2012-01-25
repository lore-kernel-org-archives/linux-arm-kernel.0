From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Jan 2012 11:34:19 +0000
Subject: [PATCH 5/5] ARM: pgtable: get rid of TOP_PTE()
In-Reply-To: <E1RoBpX-0005ok-VX@rmk-PC.arm.linux.org.uk>
References: <20120120103433.GF1068@n2100.arm.linux.org.uk>
 <E1RoBpX-0005ok-VX@rmk-PC.arm.linux.org.uk>
Message-ID: <CAHkRjk76c8JrgBdBKe+t+zX_qJVrN4+ZmGqzsVGoLZ7M5G0xMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2012 10:36, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Get rid of the TOP_PTE() macro as we now have proper accessor functions
> instead. ?No one should be directly referencing the top pte table
> anymore.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
