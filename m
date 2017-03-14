From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 14 Mar 2017 10:23:53 +0000
Subject: Neophyte questions about PCIe
In-Reply-To: <826d0a3f-753f-0330-5792-e11beb78d6bf@free.fr>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <9ba05c2c-57ef-b2c0-6a7c-457c392d98b5@free.fr>
 <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
 <c0a353cb-aa1f-25db-eccd-7a1618e655b3@free.fr>
 <20170313214024.GD8232@bhelgaas-glaptop.roam.corp.google.com>
 <826d0a3f-753f-0330-5792-e11beb78d6bf@free.fr>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFB0422@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mason
> Sent: 13 March 2017 21:58
...
> I'd like to push support for this PCIe controller upstream.
> 
> Is the code I posted on the right track?
> Maybe I can post a RFC patch tomorrow?

I think you need to resolve the problem of config space (and IO) cycles
before the driver can be deemed usable.

	David
