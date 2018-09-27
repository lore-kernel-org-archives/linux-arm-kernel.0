From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 27 Sep 2018 18:51:35 +0800
Subject: [PATCH v2] arm64: dts: allwinner: a64-olinuxino: set the PHY TX
 delay
In-Reply-To: <20180926194824.8832-1-rodrigo@tjader.xyz>
References: <20180926170545.ogcmt36ff7jmqxkl@flea>
 <20180926194824.8832-1-rodrigo@tjader.xyz>
Message-ID: <CAGb2v67iwJ--dc6V6Vb0fukd4x_2RbCv5wOnHMUYxpZOJvL-YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 3:49 AM Rodrigo Exterck?tter Tj?der
<rodrigo@tjader.xyz> wrote:
>
> The PHY found on the A64-OLinuXino requires a TX delay in order to
> operate properly. Olimex uses a 600ps second delay in their BSP, and
> that has been found to work, so let's use that value in the current
> DT.
>
> Signed-off-by: Rodrigo Exterck?tter Tj?der <rodrigo@tjader.xyz>

Applied for 4.20. Thanks.
