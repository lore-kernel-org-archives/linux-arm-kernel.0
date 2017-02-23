From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 23 Feb 2017 10:56:11 +0000
Subject: [PATCH V2 1/3] arm64: dts: Add basic DT to support Spreadtrum's
 SP9860G
In-Reply-To: <CAAfSe-t8pVM=bO+S4YatE0rYKgeeZntDbV4ufD5sC3jQYCwVMg@mail.gmail.com>
References: <1487660104-15693-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1487660104-15693-2-git-send-email-chunyan.zhang@spreadtrum.com>
 <20170221162744.GA29581@linaro.org> <20170222034632.GA18116@spreadtrum.com>
 <CANLsYkyba+QscLK5m=Fb4ErK_WEtyteR0ozS47W48izhrbSBfg@mail.gmail.com>
 <CAAfSe-t8pVM=bO+S4YatE0rYKgeeZntDbV4ufD5sC3jQYCwVMg@mail.gmail.com>
Message-ID: <76146c97-d4ff-7058-0ca7-6b2baa3bf5fe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunyan,

On 23/02/17 06:20, Chunyan Zhang wrote:
[...]

>>> I noticed Juno use the 2), would you suggest that way?
>>
>> It is better to describe the HW component themselves rather than where
>> they are in the topology - the address of the component will make sure
>> the names are unique.  So just the component type (etm, funnel,
>> replicator, ....) and the address they are located at.
>>
> 
> OK. And to avoid making other person confused in the future, is it
> better to revise juno-base.dtsi according to this convention?
> 

Yes, it was noticed by Olof and should be now fixed for v4.11(already
queued). You can check linux-next if you want to have a look before it
gets merged.

-- 
Regards,
Sudeep
