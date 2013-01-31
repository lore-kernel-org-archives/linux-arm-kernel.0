From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jan 2013 16:23:22 +0000
Subject: BogoMIPS change in 3.6+
In-Reply-To: <510A988F.6030508@gmail.com>
References: <510A988F.6030508@gmail.com>
Message-ID: <20130131162322.GD835@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Jan 31, 2013 at 04:15:11PM +0000, Rob Herring wrote:
> The BogoMIPS value has changed on highbank since the commit below in
> 3.6. It is now half the value it used to be. Does that matter other than
> perception (I've checked that I'm not running at half the freq)?

Are you registering a delay timer? If not, then the delay loop should be
identical to what it was before, so that's certainly a surprise...

Are your delays ballpark correct (try 2ms)?

Will
