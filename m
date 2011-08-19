From: cjb@laptop.org (Chris Ball)
Date: Fri, 19 Aug 2011 13:03:47 -0400
Subject: [GIT PULL] mmc: atmel rework for next
In-Reply-To: <4E4A8E73.7050705@atmel.com> (Nicolas Ferre's message of "Tue, 16
	Aug 2011 17:36:19 +0200")
References: <4E4A8E73.7050705@atmel.com>
Message-ID: <m24o1dnxjg.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 16 2011, Nicolas Ferre wrote:
> Hi Chris,
>
> Please pull from:
>
> git://github.com/at91linux/linux-2.6-at91.git nfe/mmc_atmel
>
> This is a series that reworks the atmel-mci driver for a future merge of both at91_mci and atmel-mci drivers. Those patches have been discussed on the mailing-list.
> I added a tiny at91_mci patch also sent last week.

Thanks, all looks good -- pushed to mmc-next with some commit message
rewording.  Please wrap your commit messages to 75 cols in future, so
that they're viewable in "git log" without wrapping.

I'll repeat your warning text from one of the commit messages here for
the broader audience:

    Warning: at91rm9200 is not supported, to support it we need to use
    swab32 on data but I have no board to test it.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
