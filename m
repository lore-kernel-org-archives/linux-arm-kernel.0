From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 19 Jan 2016 23:15:35 +0900
Subject: [PATCH 1/2] ARM: dts: kirkwood: split lswxl into linkstation
 lswsxl and lswxl
In-Reply-To: <20160119140507.GG6554@lunn.ch>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
 <1453211342-25214-2-git-send-email-rogershimizu@gmail.com>
 <20160119140507.GG6554@lunn.ch>
Message-ID: <CAEQ9gE=saHf0TZ5aBDYC0cCMCXgHOSON8-oPwmVXuU-h4XPbFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 11:05 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Jan 19, 2016 at 10:49:01PM +0900, Roger Shimizu wrote:
>> With a few gpio/led-pin changes, including fix for the issue mentioned
>> in Debian BTS #810894.
>
> Hi Roger
>
> This fix should be a separate patch. We can then get it applied to
> stable, so it makes its way back to older kernels.

Dear Andrew,

So this patchset would be reviewed or not?
Or I have to create another patchset including both fix for
"kirkwood-lswxl.dts" and the dts split?

Cheers,
Roger
