From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Nov 2017 13:20:18 -0600
Subject: [PATCH] Add support for bq27521 battery monitor
In-Reply-To: <20171109210615.GA27638@amd>
References: <20171109210615.GA27638@amd>
Message-ID: <20171115192018.ydrebey4tbfdnolc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 10:06:15PM +0100, Pavel Machek wrote:
> 
> This adds basic support for BQ27521 battery monitor, used in Nokia N9
> and N950. In particular, battery voltage is important to be able to
> tell when the battery is almost empty. Emptying battery on N950 is
> pretty painful, as flasher needs to be used to recover phone in such case.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

For the binding,

Acked-by: Rob Herring <robh@kernel.org>
