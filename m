From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 Aug 2017 13:02:57 +0200
Subject: [PATCH v3] ARM: dts: tango4: Request RGMII RX and TX clock delays
In-Reply-To: <d669e207-ae47-4c9e-67c5-75424fde501f@sigmadesigns.com>
References: <d669e207-ae47-4c9e-67c5-75424fde501f@sigmadesigns.com>
Message-ID: <CAK8P3a2fdzrvoN5FLzmH20igc4Jxg1N1L0SmDq7idFvMeFhc_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 3:27 PM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:
> RX and TX clock delays are required. Request them explicitly.
>
> Fixes: cad008b8a77e6 ("ARM: dts: tango4: Initial device trees")
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> Arnd, Kevin, Olof, can one of you take this patch through arm-soc?

Applied to the fixes branch now.

> Greg will apply it to all stable branches, right?

He usually looks at random patches that have a 'Fixes:' line, but if you already
know that you want a bugfix to be backported, it should also come with a
'Cc: stable at vger.kernel.org' line. I've added that manually this time, but
please include it yourself if you have another patch like that.

 Thanks,

      Arnd
