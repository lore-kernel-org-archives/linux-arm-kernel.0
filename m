From: olof@lixom.net (Olof Johansson)
Date: Thu, 25 Aug 2016 16:59:54 -0700
Subject: [GIT PULL] SCPI/Vexpress fixes for v4.8-rc
In-Reply-To: <f232ba19-e359-3ef4-cce5-e76b0f35d078@arm.com>
References: <f232ba19-e359-3ef4-cce5-e76b0f35d078@arm.com>
Message-ID: <20160825235954.GC6209@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 12:01:00PM +0100, Sudeep Holla wrote:
> 
> Hi ARM-SoC guys,
> 
> I have couple of missing of_node_put fixes in vexpress/scpi drivers.
> I am not sure if these are considered as more cleanup patches rather
> than fixes as OF reference counting is not something religiously checked
> always. Let me know, I will move these to v4.9 queue otherwise.

They're not urgent but I've merged them anyway.

Thanks,


-Olof
