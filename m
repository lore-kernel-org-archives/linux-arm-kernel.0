From: jhs@mojatatu.com (Jamal Hadi Salim)
Date: Tue, 09 Sep 2014 07:44:09 -0400
Subject: [PATCH v2 0/3] net: Add Keystone NetCP ethernet driver support
In-Reply-To: <540DC00F.1080103@ti.com>
References: <1408115562-22487-1-git-send-email-santosh.shilimkar@ti.com>
 <20140821.163612.282672926741753926.davem@davemloft.net>
 <53F79DC5.8030003@ti.com> <540DC00F.1080103@ti.com>
Message-ID: <540EE809.9020901@mojatatu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/14 10:41, Santosh Shilimkar wrote:

>> The NetCP plugin module infrastructure use all the standard kernel
>> infrastructure and its very tiny.

So i found this manual here:
http://www.silica.com/fileadmin/02_Products/Productdetails/Texas_Instruments/SILICA_TI_66AK2E05-ds.pdf

Glad there is an open document!
There are a couple of ethernet switch chips I can spot there.

Can i control those with "bridge" or say "brctl" utilities?

I can see the bridge ports are exposed and i should be able to
control them via ifconfig or ip link. Thats what "standard
kernel infrastructure" means. Magic hidden in a driver is
not.

Take a look at recent netconf discussion (as well as earlier
referenced discussions):
http://vger.kernel.org/netconf-nf-offload.pdf

Maybe we can help providing you some direction?
The problem is it doesnt seem that the offload specs for
those other pieces are open? e.g how do i add an entry
to the L2 switch?

cheers,
jamal
