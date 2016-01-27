From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Jan 2016 10:52:54 +0100
Subject: [PATCH CFT] ARM: orion: implement ARM delay timer
In-Reply-To: <20160127094533.GW10826@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 27 Jan 2016 09:45:33 +0000")
References: <E1ZoD3b-0006UD-Rp@rmk-PC.arm.linux.org.uk>
 <8737tjbghx.fsf@free-electrons.com>
 <20160127094533.GW10826@n2100.arm.linux.org.uk>
Message-ID: <87twlz9wnd.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On mer., janv. 27 2016, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Jan 27, 2016 at 08:58:50AM +0100, Gregory CLEMENT wrote:
>> Hi Russell,
>>  
>>  On lun., oct. 19 2015, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
>> 
>> > Implement an ARM delay timer to be used for udelay() on orion legacy
>> > platforms.  This allows us to skip the delay loop calibration at boot.
>> >
>> > It also means that udelay() will be unaffected by CPU frequency changes
>> > when cpufreq is enabled on these platforms.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> 
>> Applied on mvebu/drivers with Acked-by tag from  Andrew Lunn
>
> And, I hope, my tested-by which delayed Andrew's ack until December,

Now yes :)

Gregory

> despite the patch being marked as CFT because I wanted _others_ to
> test it (which never happened.)
>
> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
