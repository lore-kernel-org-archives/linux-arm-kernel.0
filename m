From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Tue, 19 Mar 2013 23:19:39 +0900
Subject: [BUG][mvebu] mvneta: cannot request irq 25 on openblocks-ax3
In-Reply-To: <20130319133928.GE3137@localhost>
References: <51486445.8040506@hitachi.com> <20130319133928.GE3137@localhost>
Message-ID: <514873FB.5050202@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

(2013/03/19 22:39), Ezequiel Garcia wrote:
> Hi Masami,
> 
> On Tue, Mar 19, 2013 at 10:12:37PM +0900, Masami Hiramatsu wrote:
>>
>> Here I've hit a bug on the recent kernel. As far as I know, this bug
>> exists on 3.9-rc1 too.
>>
>> When I tried the latest mvebu for-next tree
>> (git://git.infradead.org/users/jcooper/linux.git mvebu/for-next),
>> I got below warning at bootup time and mvneta didn't work (link was never up).
>> I ensured that "ifconfig ethX up" always caused that.
>>
>> Does anyone succeed to boot openblocks-ax3 recently or hit same
>> trouble?
> 
> This is a known bug. Gregory Clement already has a fix and he
> will submit it soon. In case you need this fixed ASAP, I'm attaching
> you a patch with a fix.

Thanks! I'll try that.

> Please note the attached patch is not ready for mainline inclusion,
> as I said Gregory will submit a cleaner version soon.

Yeah, I look forward to it :)

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
