From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 18 Mar 2015 15:41:36 +0530
Subject: Is cpufreq-dt safe without regulator support?
In-Reply-To: <20150318100336.GM4638@lukather>
References: <CAGb2v679W_NqG2d597tV9W-5ROZRTH-K542fofA_UbREDjfBhg@mail.gmail.com>
 <CAKohponnp3WgFO4nDwGwTYE9_mxzX5ttjA-Xi-9YJ7grjNcymQ@mail.gmail.com>
 <CAGb2v65z8hGdPqeW9DVa41PtMe6n8-=Gkw-YDu4mFiCbvvGT4A@mail.gmail.com>
 <CAKohpomy6HkGYTm5KzjrWkk-RgipVkeHfoM1hLz9oAcZSWHcdg@mail.gmail.com>
 <20150318100336.GM4638@lukather>
Message-ID: <CAKohponKrwm47YQ0oRjYo9tMBu4gkOvi8fTWCuaWA1SNbT0b9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2015 at 15:33, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Another solution would be to have the safe OPPs in the DTSI, and the
> one that requires some PMIC support in the board DTS.

Yes .dtsi and .dts files do get merged, but I don't think that will
happen in case
of OPPs as well. As we are talking about a single field with any array of OPP
pairs.
