From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 17 Dec 2013 16:04:48 -0800
Subject: [PATCH v5] clk: si570: Add a driver for SI570 oscillators
In-Reply-To: <20131217234340.23538.9631@quantum>
References: <1379806839-13762-1-git-send-email-soren.brinkmann@xilinx.com>
 <b625092b-682c-4072-85a6-9f9d7f378ec0@VA3EHSMHS043.ehs.local>
 <20131002231751.4343.81234@quantum> <52AC8857.8070504@roeck-us.net>
 <20131217234340.23538.9631@quantum>
Message-ID: <20131218000448.GA9857@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 03:43:40PM -0800, Mike Turquette wrote:
> Quoting Guenter Roeck (2013-12-14 08:33:27)
> > On 10/02/2013 04:17 PM, Mike Turquette wrote:
> > > Quoting S?ren Brinkmann (2013-10-02 10:20:38)
> > >> Hi Mike,
> > >>
> > >> could you please comment on this/apply it to clk-next?
> > >
> > > It looks good and is in the queue. Will show up in clk-next in a few
> > > days.
> > >
> > Hi Mike,
> > 
> > trying again ... what happened with this driver ? Any reason for not pushing it after all ?
> 
> This got reverted with several other patches right before 3.12 dropped.
> Unfortunately clk-next broke linux-next two days before 3.12 came out
> and I had to revert to a known good state, excluding this driver.
> 
> I've added it back to clk-next now towards 3.13. Sorry for the
> inconvenience.
> 
No problem. Thanks a lot for the update.

Guenter
