From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 19 Jul 2018 09:06:39 -0500
Subject: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
In-Reply-To: <7e1cce0b-fc86-b900-2019-a85c5e5ba2ae@amlogic.com> (Yixun Lan's
 message of "Tue, 17 Jul 2018 09:24:02 +0800")
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
 <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
 <1531216472.2708.71.camel@baylibre.com> <7hfu0jmhbe.fsf@baylibre.com>
 <7e1cce0b-fc86-b900-2019-a85c5e5ba2ae@amlogic.com>
Message-ID: <7h601be2vk.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

[...]

>> 
>> As Jerome said, I think consistency is an important goal, so leaving off
>> the "meson-" for drivers/clk is fine with me.
>> 
> ok
>
>> Also for consistency, for the rest of the drivers, keeping "meson-" is
>> probably the right thing to do.
>> 
> ok, for the above, you are talking about the already exist compatible
> names? or the patches we will push in the future?

I'm talking about future patches.

>> However, patches would be welcome to add compatibles without the "meson"
>> for the rest of the drivers & documentation as well, but please do not
>> remove any compatibles.
>> 
> I assume you are talking about the patches in the future we will push?
> to drop the "meson".
>
> I'm confused here, as the above two paragraphs conflict with each other

Yeah, what I wrote is confusing, sorry about that.

What I mean is that new patches should stay consistent with compatibles
in their existing drivers/subsystems.  That means keeping the "meson-"
prefix for everything except drivers/clk.

In addition to that, patches would be welcome for *adding* compatibles
without "meson" to all the current drivers.

Kevin
