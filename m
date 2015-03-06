From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 6 Mar 2015 01:58:42 -0300
Subject: [PATCH v2] ARM: mx25: Remove mach-mx25_3ds board file
In-Reply-To: <20150306044912.GR20455@dragon>
References: <1425385962-3109-1-git-send-email-fabio.estevam@freescale.com>
 <20150306044912.GR20455@dragon>
Message-ID: <CAOMZO5BdD6=7uuxyBhqY74OSG0bD_jK-j51qJPtMXk=s8_9uQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 6, 2015 at 1:49 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Mar 03, 2015 at 09:32:42AM -0300, Fabio Estevam wrote:
>> imx25-pdk.dts provides a more complete support than the board file version, so
>> let's get rid of the board file.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> Changes since v1:
>> - Rebased against imx/cleanup branch
>
> I do not know what went wrong.  The v2 still doesn't apply on my branch.

Maybe because I generated with -D option. I have sent a v3 without the
-D option and it should apply cleanly.
