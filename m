From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 13 Aug 2010 09:15:59 +0530
Subject: Request for holding Ryan's patch set for SPEAr
In-Reply-To: <4C645C98.1020401@bluewatersys.com>
References: <4C639611.8060107@st.com> <4C645C98.1020401@bluewatersys.com>
Message-ID: <4C64BFF7.9020500@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/13/2010 2:12 AM, Ryan Mallon wrote:
> On 08/12/2010 06:34 PM, viresh kumar wrote:
>> Russell,
>>
>> We are facing some problem in organizing patches for spear and need some
>> help from you. Actually there are 5 patches for spear sent by Ryan some
>> time back, they were related to removing multiple defconfigs and merging
>> them for a family of machines. (Ryan did it for spear3xx).
>>
>> Following is Ryan's patchset:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017254.html
>>
>> We have been working on linux-2.6.32 until now and so didn't sent any further
>> patches to mailing list because of other commitments. Now we have over 150 
>> patches which we need to add to mainline. 
>>
>> Since all our patches are based on multiple defconfig approach, a lot of work
>> is required to rebase our patches over ryan's patchset.
>>
>> We request if you can hold ryan's patches. I would provide those patches over
>> and above my patchset. This will make rebasing easier.
> 
> Probably the easiest way is if I hold off my patches and rebase them
> after you have posted your patches. The other approach would be for you
> to apply them on top of your tree, make any necessary changes, and just
> keep my From/Signed-off-by tag when you post to the list.
> 

Ryan, I will go with the second approach.

Russell, Is this approach fine for you??

Thanks,
viresh.
