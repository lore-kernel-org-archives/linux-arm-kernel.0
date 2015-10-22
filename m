From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 22 Oct 2015 02:38:40 +0200
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <5628022A.9050707@mcfarlanes.me>
References: <1444722697.16876.55.camel@debian.org>
 <5626B4DC.8000407@mcfarlanes.me> <5627F4E8.3030907@mcfarlanes.me>
 <1445461864.32735.21.camel@debian.org>
 <5628022A.9050707@mcfarlanes.me>
Message-ID: <20151022003840.GA930@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In which case it is using the board file
> 
> How do I force it to use the dtb?

FYI: Mainline 3.16 kernel does support device tree for QNAP. So it
should be possible to boot using it.

My gut feeling is that DT is not part of the problem. So if you cannot
quickly find a way to force DT booting, can i suggest you binary chop
kernel versions between what does work and what does not, independent
of if it used DT or not.

Thanks
	Andrew
