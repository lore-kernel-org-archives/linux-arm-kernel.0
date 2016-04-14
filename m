From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Apr 2016 09:48:49 +0100
Subject: [Question] refcount of DT node
In-Reply-To: <CAK7LNATFUW2KXUpFas6C_SJ0C7Qb1DWU0njLg-FCYciK2U6Oag@mail.gmail.com>
References: <CAK7LNATFUW2KXUpFas6C_SJ0C7Qb1DWU0njLg-FCYciK2U6Oag@mail.gmail.com>
Message-ID: <20160414084849.GT19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 04:47:57PM +0900, Masahiro Yamada wrote:
> Hi experts.
> 
> My understanding of refcount of DT node is poor.

The message from DT people is... don't worry about DT node refcounting.
Do whatever you want with it, they don't care whether you have correct
refcounting or not.

The background behind that is that I've tried to fix the refcounting,
and even had the coccinelle people generate some stuff to work on this
issue, but DT people's attitude towards it is "don't bother".

So yes, people may get it wrong, but it seems it's something that DT
people want ignored.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
