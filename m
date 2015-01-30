From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 30 Jan 2015 11:31:18 +0100
Subject: [PATCH] ARM: dts: mvebu: add ethernet to the cm-a510 board
In-Reply-To: <54CB5267.5060004@gmail.com>
References: <E1YH5bU-0005mG-3L@bombadil.infradead.org>
 <54CB5267.5060004@gmail.com>
Message-ID: <20150130113118.5523ed68@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Jan 2015 10:44:07 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> I had a closer look on the Compulab website of the SoM [1] and think
> that we'll have to convert it to dove-cm-a510.dtsi and the baseboard
> Gabriel is using (maybe SBC-A510 [2]).

Sebastian,

I don't understand why the A510 contained in the cm-a510 should be
different from the one of the other boards (I just noticed a second
ethernet and a WiFi device - but, is the Compulab document up to date?).

If it is the same, the dove.dtsi should work (and it seems to work for
Gabriel).

The only difference with the cm-a510 is the presence or not of the
connectors. So, all the Dove devices could be enabled in the DT, and,
if some room is needed in the board, the .config could be adapted
removing the useless drivers and have a minimal kernel.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
