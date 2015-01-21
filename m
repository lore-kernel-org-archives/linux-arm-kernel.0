From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Jan 2015 13:49:17 +0000
Subject: Unregisrtering a platform driver from another platform driver.
In-Reply-To: <CAAVaN8xnO5mE1uwW=SPENwOugLv3n+JeNCE9ZycEK2_9QmXSPw@mail.gmail.com>
References: <CAAVaN8xnO5mE1uwW=SPENwOugLv3n+JeNCE9ZycEK2_9QmXSPw@mail.gmail.com>
Message-ID: <20150121134917.GR26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 10:27:35AM +0000, Andy Ng wrote:
> Dear Colleagues,
> 
> I would like to call "platform_driver_unregister" for a static module
> A from a static  module B.
> The static module A register its name  "physmap-flash".
> 
> Is there any kernel API to search and find the "physmap-flash" device,
> and then call unregistered with "platform_driver_unregister" from
> module B.

Why do you want to do this?  What is your motivation?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
