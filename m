From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 29 Sep 2011 19:39:05 -0600
Subject: [PATCH 0/9] Device tree support for regulators
In-Reply-To: <1317118372-17052-1-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Message-ID: <20110930013905.GJ12606@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 03:42:43PM +0530, Rajendra Nayak wrote:
> Hi Mark, Grant,
> 
> This is a respin of my RFC series I posted sometime back
> and is now based on top of the latest omap i2c-twl support
> series posted by Benoit
> git://gitorious.org/omap-pm/linux.git for_3.2/4_omap_dt_i2c_twl
> 
> some changes done since the RFC:
> 1. twl driver fixed to remove hardcoded board params
> 2. regulator helpers moved from drivers/of to drivers/regulator
> 3. Better compatible definitions for specific device type
> 4. twl regulator driver doing internal table lookup based on
> compatible rather then pdev->id
> 5. Seperate fixed voltage regulator bindings defined
> 6. Changed the way devices associate with regulators
> i.e using <name>-supply = <&regulator-phandle>;

Overall looks fairly good other than the comments made by Mark and myself.

g.
