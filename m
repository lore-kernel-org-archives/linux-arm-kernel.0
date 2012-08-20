From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 20 Aug 2012 16:51:20 +0200
Subject: [PATCH 01/11] pinctrl: mvebu: pinctrl driver core
In-Reply-To: <CACRpkdaozBQPe1PkjaKrnqYZ=tpX1mv1iS-rCrJaSFAsQqzgnA@mail.gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>	<1344689809-6223-2-git-send-email-sebastian.hesselbarth@gmail.com>	<CACRpkda0wUW4E3y=ucGRFu5fwwyFWo2dc=4qBaH6CFSOW2ZL_A@mail.gmail.com>	<CABJ1b_TCF=Jfb0uuoh-M87n6faezj4OqZ4S_nJLA0yKga2-ioQ@mail.gmail.com>
 <CACRpkdaozBQPe1PkjaKrnqYZ=tpX1mv1iS-rCrJaSFAsQqzgnA@mail.gmail.com>
Message-ID: <50324EE8.9010206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2012 04:18 PM, Linus Walleij wrote:
>> I'll review the variant types but inside pinctrl-mvebu variant
>> is used as a bit mask to distinguish different variants. Anyway,
>> they should always be the same size.
>
> Aha bitmask, seems you can only have 8 different variants of
> the Marvell's then?

Only 8 different variants of one SoC! Currently, there are 5 for
Kirkwood, none for Dove. I think there are two more Kirkwood's that
never appeared in public, but it is still < 8.

>> Well, I see if I can clarify the description but wrt the datasheet it
>> _should_ be quite obvious.
>
> I mainly worry about being able to read the code and figure out
> what's going on, if the datasheet is vital then pls include some
> link to it or so in the header of the file (but preferrably the code
> should speak for itself).

Ok, I clarify whats meant by mvebu_*_ctrl/ctrl_setting/mode. I am not
that happy with that names either, but honestly pinctrl core already
took all names that I'd have chosen. Therefore, I chose some that do
not interfere with pinctrl core as the meaning is different.

Sebastian
