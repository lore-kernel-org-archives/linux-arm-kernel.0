From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 14 Jul 2018 16:30:40 +0200
Subject: [PATCH 1/3] dt-bindings: clk: g12a: New binding for Meson-G12A SoC
In-Reply-To: <f6f387ff-271b-9b4b-5b6e-072b4e56d840@amlogic.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-2-git-send-email-jian.hu@amlogic.com>
 <1531214976.2708.52.camel@baylibre.com>
 <f6f387ff-271b-9b4b-5b6e-072b4e56d840@amlogic.com>
Message-ID: <CAFBinCDW_Z-Ku+x8YsaM0CuTP6KD4PQ2uf94m3DZn5kCmvK9GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 3:06 PM Jian Hu <jian.hu@amlogic.com> wrote:
>
>
>
> On 2018/7/10 17:29, Jerome Brunet wrote:
> > On Mon, 2018-07-09 at 19:12 +0800, Jian Hu wrote:
> >> Add new binding for Meson-G12A SoC Everything-Else part
> >
> > nitpick: I would prefer if the words 'clock' and 'controller' was somewhere in
> > the description.
> >
> > Maybe "add new clock controller compatible for the EE domain of the g12a SoC" ?
>
> Patch 1 and 2 have squashed, the commit message focuse which one?
I would use the information from both commit messages (for example you
could use the what Jerome already suggested and extend it with "and
add a header file which contains preprocessor macros to identify the
clocks provided by this clock controller")


Regards
Martin
