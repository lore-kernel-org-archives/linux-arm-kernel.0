From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 07 Oct 2014 11:11:47 +0200
Subject: [PATCH v2] [media] Remove references to non-existent PLAT_S5P
 symbol
In-Reply-To: <1412613395.8561.1.camel@x220>
References: <1412611806-9346-1-git-send-email-s.nawrocki@samsung.com>
 <1412613395.8561.1.camel@x220>
Message-ID: <5433AE53.1010807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/14 18:36, Paul Bolle wrote:
> On Mon, 2014-10-06 at 18:10 +0200, Sylwester Nawrocki wrote:
>> > The PLAT_S5P Kconfig symbol was removed in commit d78c16ccde96
>> > ("ARM: SAMSUNG: Remove remaining legacy code"). However, there
>> > are still some references to that symbol left, fix that by
>> > substituting them with ARCH_S5PV210.
>> > 
>> > Reported-by: Paul Bolle <pebolle@tiscali.nl>
>> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> Thanks for picking this up!
> 
> Should
>      Fixes: d78c16ccde96 ("ARM: SAMSUNG: Remove remaining legacy code")
> 
> be added so this will end up in stable for v3.17?

Thanks for the suggestion. I will add it to the commit description
and Cc stable before including the patch in a pull request to Mauro.
And will resend the other patch.

--
Regards,
Sylwester
