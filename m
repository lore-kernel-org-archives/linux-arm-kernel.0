From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 20 Sep 2015 20:09:30 +0200
Subject: [PATCH RESEND 0/2] arm: dts: berlin: use stdout-path
In-Reply-To: <1442212933-760-1-git-send-email-jszhang@marvell.com>
References: <1442212933-760-1-git-send-email-jszhang@marvell.com>
Message-ID: <55FEF65A.4090506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.09.2015 08:42, Jisheng Zhang wrote:
> These two simple patches use stdout-path to specify the console.
> The first patch add aliases for serial uarts. The second patch
> removes the console argument from the command line, uses stdout-path
> instead.
>
> Jisheng Zhang (2):
>    arm: dts: berlin: add aliases for serial
>    arm: dts: berlin: use stdout-path

Applied to berlin/dt.

Thanks,
   Sebastian

>   arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        | 3 ++-
>   arch/arm/boot/dts/berlin2.dtsi                    | 6 ++++++
>   arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 3 ++-
>   arch/arm/boot/dts/berlin2cd.dtsi                  | 5 +++++
>   arch/arm/boot/dts/berlin2q-marvell-dmp.dts        | 3 ++-
>   arch/arm/boot/dts/berlin2q.dtsi                   | 5 +++++
>   6 files changed, 22 insertions(+), 3 deletions(-)
>
