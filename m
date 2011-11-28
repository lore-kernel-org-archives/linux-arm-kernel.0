From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Nov 2011 22:35:50 -0800
Subject: [PATCH] arm/tegra: Fix build error with tegra_assert_system_reset
In-Reply-To: <20111124203443.GU9581@n2100.arm.linux.org.uk>
References: <1322009631-711-1-git-send-email-swarren@nvidia.com>
 <20111123095009.GG9581@n2100.arm.linux.org.uk>
 <74CDBE0F657A3D45AFBB94109FB122FF174F08C6CC@HQMAIL01.nvidia.com>
 <20111124203443.GU9581@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMh4_YRpaXgapJ9DLPH_A8ft=W1tf10kFdQF90JN=R8ziw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 12:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 23, 2011 at 08:59:48AM -0800, Stephen Warren wrote:
>> OK, I tested that and it works too.
>
> Great. ?Here's the final patch - could I have an ack for it please?
>
> Thanks.
>
> 8<======
> ARM: restart: tegra: use new restart hook
>
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Olof Johansson <olof@lixom.net>

(tested-by as well, but adding multiple entries seems silly)


-Olof
