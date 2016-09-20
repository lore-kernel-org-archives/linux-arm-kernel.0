From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Tue, 20 Sep 2016 15:23:02 +0200
Subject: [PATCH v4 2/5] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 initial support
In-Reply-To: <CAOMZO5B_ahBJr_Tgz_HShmG9heUwCj4K0N3FHhxja1yg0gCUGA@mail.gmail.com>
References: <1473618641-10159-1-git-send-email-jagan@amarulasolutions.com>
 <1473618641-10159-3-git-send-email-jagan@amarulasolutions.com>
 <CAOMZO5CsrrqqUPaVbU-ya79VSXgxyspa_fbr8HY1voJgpy2LLg@mail.gmail.com>
 <CAMty3ZDKrXxmwDFxSBvL_anJQPdXEfnJ40uNv5B6KssQyJJKhA@mail.gmail.com>
 <CAOMZO5B_ahBJr_Tgz_HShmG9heUwCj4K0N3FHhxja1yg0gCUGA@mail.gmail.com>
Message-ID: <CAOf5uw=bMMa98RP=kvA=NfS89TWOEqU3Q2HjpEmzUTVrdg2=sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio

On Wed, Sep 14, 2016 at 8:00 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Sep 14, 2016 at 2:43 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>
>> OK, but where it showed on the processor manual? I only find LDO_2P5
>
> It is not a SoC regulator. It is the regulator that powers the CAN transceiver.

Engicam use fixed regulator always on and on on boot. Their board does
not have any
external pmu. Is this answer to your comment?

Michael
