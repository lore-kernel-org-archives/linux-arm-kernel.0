From: robherring2@gmail.com (Rob Herring)
Date: Thu, 31 Jan 2013 14:57:56 -0600
Subject: BogoMIPS change in 3.6+
In-Reply-To: <20130131162322.GD835@mudshark.cambridge.arm.com>
References: <510A988F.6030508@gmail.com>
 <20130131162322.GD835@mudshark.cambridge.arm.com>
Message-ID: <510ADAD4.2050600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2013 10:23 AM, Will Deacon wrote:
> Hi Rob,
> 
> On Thu, Jan 31, 2013 at 04:15:11PM +0000, Rob Herring wrote:
>> The BogoMIPS value has changed on highbank since the commit below in
>> 3.6. It is now half the value it used to be. Does that matter other than
>> perception (I've checked that I'm not running at half the freq)?
> 
> Are you registering a delay timer? If not, then the delay loop should be
> identical to what it was before, so that's certainly a surprise...
> 
> Are your delays ballpark correct (try 2ms)?
> 

Yes, the delays are correct and this is an A9. So I guess this may be a
surprise, but seems it is a non-issue. I'm sure I'll be getting asked
about this...

Rob
