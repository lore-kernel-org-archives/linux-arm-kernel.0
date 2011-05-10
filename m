From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue, 10 May 2011 17:51:12 +0530
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <20110510112734.54160824@lxorguk.ukuu.org.uk>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com><201105041511.54095.arnd@arndb.de><4DC163D7.9010309@grandegger.com><201105041648.37199.arnd@arndb.de><4DC17831.3070801@grandegger.com><F1859F4DD03040248B42AC947304D39B@subhasishg>
	<20110510112734.54160824@lxorguk.ukuu.org.uk>
Message-ID: <2BFFDAA0A0DE4820876E5549867938EC@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Yes, In case if we allow the ALL implementation, it hogs the CPU.
>> In that case we do not need the PRU. The whole purpose of the PRU
>> is to offload the processor for any such implementations. 
> 
> So the kernel presumably needs to switch between using the PRU and native
> according to the number of ids being requested at the time ?

All the IDs are programmed into the PRU data RAM.
The Kernel receives interrupts based upon these IDs.
I could not clearly follow "PRU and native", could you please elaborate.

> That would be roughly what we do with other things (eg IP multicast) so
> that apps don't need to know all the innards

 
