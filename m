From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 18 Mar 2015 16:05:59 +0530
Subject: Is cpufreq-dt safe without regulator support?
In-Reply-To: <20150318102017.GN4638@lukather>
References: <CAGb2v679W_NqG2d597tV9W-5ROZRTH-K542fofA_UbREDjfBhg@mail.gmail.com>
 <CAKohponnp3WgFO4nDwGwTYE9_mxzX5ttjA-Xi-9YJ7grjNcymQ@mail.gmail.com>
 <CAGb2v65z8hGdPqeW9DVa41PtMe6n8-=Gkw-YDu4mFiCbvvGT4A@mail.gmail.com>
 <CAKohpomy6HkGYTm5KzjrWkk-RgipVkeHfoM1hLz9oAcZSWHcdg@mail.gmail.com>
 <20150318100336.GM4638@lukather>
 <CAKohponKrwm47YQ0oRjYo9tMBu4gkOvi8fTWCuaWA1SNbT0b9g@mail.gmail.com>
 <20150318102017.GN4638@lukather>
Message-ID: <CAKohpokWjsG2pOAFvqRggBuOGdo1Pi5hss4sUVBa25eNpoqKJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2015 at 15:50, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Sorry, what I meant was to redefine the whole OPPs set in the DTS,
> overriding the one in the DTSI.
>
> That would add some duplication, but still far less than what you
> first suggested in our case.

Okay, I wasn't aware of the fact that we can override entries this way.
But still it doesn't look right to me from readability point of view.

It would be very easy for people to confuse when they will see two
similar entries of OPP tables, one in dtsi and other one in dts.

Its okay if duplication is there, atleast its readable.

Over that, all this mess will get fixed up with the new OPP bindings,
which are currently under discussion over lists.

--
viresh
