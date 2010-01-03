From: mkl0301@hotmail.com (mkl lin)
Date: Sun, 3 Jan 2010 17:29:40 +0000
Subject: SMP issues on ARM11 MPCore
In-Reply-To: <SNT109-W65CC8A14EB694801F84BFDA7750@phx.gbl>
References: <SNT109-W391FD03251D32533FAE84DA77F0@phx.gbl>, ,
	<20100101205850.GI16220@n2100.arm.linux.org.uk>,
	<SNT109-W65CC8A14EB694801F84BFDA7750@phx.gbl>
Message-ID: <SNT109-W45702CDD2270FCEEA8A290A7750@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>> It could be something to do with write allocate caches - we don't support
>> these particularly well in the kernel, and I wouldn't be surprised if
>> you've found some problem there.
>>
>> The fact that it only happens in SMP mode rather points at that, because
>> that's one of the few hardware configurations which does have write
>> allocate caches. To confirm this, we need someone who can run your
>> tests on a UP platform which has write allocate caches...
> I'm not familiar with the write allocate cache, but the same test without SMP doesn't have such issue.
> Or should I try to run 1CPU in SMP mode?
1CPU in SMP mode doesn't have this behavior, with maxcpus=1.
Would this two tests do instead?

Best Regards,
Mac Lin.

 		 	   		  
_________________________________________________________________
Windows Live: Friends get your Flickr, Yelp, and Digg updates when they e-mail you.
http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_3:092010
