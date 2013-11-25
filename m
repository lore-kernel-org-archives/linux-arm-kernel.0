From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Nov 2013 12:43:58 -0200
Subject: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
In-Reply-To: <20131125133659.GA30476@S2101-09.ap.freescale.net>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
 <20131125031029.GC11613@S2101-09.ap.freescale.net>
 <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
 <20131125133659.GA30476@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5DW3pSxPGe6N0CRiCEc+iVV9X_13JbzAvuFbb4jide+zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark/Thierry,

On Mon, Nov 25, 2013 at 11:37 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Nov 25, 2013 at 11:26:53AM -0200, Fabio Estevam wrote:
>> Looks like we need to apply this one to make sure backlight works:
>> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/281826
>
> But per Thierry's comment below, this is the exactly the case that we
> should avoid - patch individual board DTS file to add a dummy/fake
> regulator to get it through.
>
> | But even so, the regulator core now has functionality to return a dummy
> | regulator if none is specified in DT, specifically so that users don't

What commit provides this regulator core functionality?

Looks like it has not reached 3.13-rc1.

Regards,

Fabio Estevam
