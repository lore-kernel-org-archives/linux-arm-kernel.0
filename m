From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Mar 2015 11:20:17 +0100
Subject: Is cpufreq-dt safe without regulator support?
In-Reply-To: <CAKohponKrwm47YQ0oRjYo9tMBu4gkOvi8fTWCuaWA1SNbT0b9g@mail.gmail.com>
References: <CAGb2v679W_NqG2d597tV9W-5ROZRTH-K542fofA_UbREDjfBhg@mail.gmail.com>
 <CAKohponnp3WgFO4nDwGwTYE9_mxzX5ttjA-Xi-9YJ7grjNcymQ@mail.gmail.com>
 <CAGb2v65z8hGdPqeW9DVa41PtMe6n8-=Gkw-YDu4mFiCbvvGT4A@mail.gmail.com>
 <CAKohpomy6HkGYTm5KzjrWkk-RgipVkeHfoM1hLz9oAcZSWHcdg@mail.gmail.com>
 <20150318100336.GM4638@lukather>
 <CAKohponKrwm47YQ0oRjYo9tMBu4gkOvi8fTWCuaWA1SNbT0b9g@mail.gmail.com>
Message-ID: <20150318102017.GN4638@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 03:41:36PM +0530, Viresh Kumar wrote:
> On 18 March 2015 at 15:33, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Another solution would be to have the safe OPPs in the DTSI, and the
> > one that requires some PMIC support in the board DTS.
> 
> Yes .dtsi and .dts files do get merged, but I don't think that will
> happen in case
> of OPPs as well. As we are talking about a single field with any array of OPP
> pairs.

Sorry, what I meant was to redefine the whole OPPs set in the DTS,
overriding the one in the DTSI.

That would add some duplication, but still far less than what you
first suggested in our case.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/4bd1ef80/attachment.sig>
