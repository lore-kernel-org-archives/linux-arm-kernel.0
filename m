From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 30 Jan 2015 14:43:08 +0200
Subject: 3.19 on Nokia n900: audio quality awful
In-Reply-To: <54CB7BA6.2070408@ti.com>
References: <20150106170433.GA5408@amd> <20150118120139.GA1509@amd>
 <54C63F1C.6010703@ti.com> <54C92752.9000004@bitmer.com>
 <20150128224144.GA28956@amd> <20150129073529.GA19122@bitmer.com>
 <54CA173F.1070301@ti.com> <20150130102639.GA19595@amd>
 <20150130103748.GA24623@amd> <54CB7BA6.2070408@ti.com>
Message-ID: <54CB7C5C.9000807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2015 02:40 PM, Peter Ujfalusi wrote:
> On 01/30/2015 12:37 PM, Pavel Machek wrote:
>> Hi!
>>
>>> I looked around the diff between 3.18 and 3.19, reverted these, and
>>> audio quality is back to reasonable level.
>>
>> Actually, reverting 368494093354ac613a80c2e1d77602aa12473cf0 seems
>> enough.
>>
>> Any quick patches to test? Or should we revert so that 3.19-final
>> works ok?
> 
> I'll send the fix in a minute, thanks for finding it ;)

And here it is:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/087228.html

-- 
P?ter
