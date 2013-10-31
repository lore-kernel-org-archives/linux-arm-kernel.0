From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Oct 2013 10:07:52 -0700
Subject: [PATCH] clk: fix boot panic with non-dev-associated clocks
In-Reply-To: <CAOMZO5C4+K+RfHOpex7EwLObPV4Uy8YmjdVx2HPv36ZGAKeSZA@mail.gmail.com>
References: <1383238174-14650-1-git-send-email-olof@lixom.net>
 <CAOMZO5C4+K+RfHOpex7EwLObPV4Uy8YmjdVx2HPv36ZGAKeSZA@mail.gmail.com>
Message-ID: <CAOesGMgU6qJMpXi5DGe7=XbObiWh8icNFRhZv_9ot+KZMNcTnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 10:05 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Olof,
>
> On Thu, Oct 31, 2013 at 2:49 PM, Olof Johansson <olof@lixom.net> wrote:
>> Fixes a panic at boot on many platforms. For example, on imx (wandboard),
>> I get:
>
> With this patch applied console messages appears on 20131031, but it
> seems we still have other issues:


Yeah, there's lots of badness in last night's -next. :(

Of course, this one will be nasty to bisect down since I need the clk
fix on top. I'll give it a go.

-Olof
