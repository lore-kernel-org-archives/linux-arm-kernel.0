From: helmut.raiger@hale.at (Helmut Raiger)
Date: Thu, 24 Mar 2011 08:06:46 +0100
Subject: i.MX31 suspend and VSTBY question
In-Reply-To: <56132A77AB93C141BF06E6B96CA6CFEA1BC3AB@039-SN1MPN1-004.039d.mgd.msft.net>
References: <4D874A69.9010209@hale.at>	<56132A77AB93C141BF06E6B96CA6CFEA1BC28F@039-SN1MPN1-004.039d.mgd.msft.net>	<4D877A9F.4010108@hale.at>
	<56132A77AB93C141BF06E6B96CA6CFEA1BC3AB@039-SN1MPN1-004.039d.mgd.msft.net>
Message-ID: <4D8AED86.1030207@hale.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

     did you find something, I've still got no solution to this. I 
checked the CCM registers and compared them with the 2.6.21 version. The 
differences I found were concerning the DPTC and DVFS registers mainly. 
However quite a few clock gate settings were different as well. Might 
this influence the state retention mode in some way?

Helmut

> Unfortunately our last fully tested version was on 2.6.24. I'll dig around some more to see if there's something that might be useful to you.
>
> Dinh
>



--
Scanned by MailScanner.
