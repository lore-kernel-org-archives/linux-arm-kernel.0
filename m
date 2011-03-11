From: shiraz.linux.kernel@gmail.com (shiraz hashim)
Date: Fri, 11 Mar 2011 18:32:26 +0530
Subject: questions about arm trustzone
In-Reply-To: <bb0c3855a121603232d022b4062752a6@mail.gmail.com>
References: <AANLkTi=eCOiP7MrUSG4WRMN0kj_+ZWvZ=z7VYDfkshU_@mail.gmail.com>
	<8yad3nlh18e.fsf@huya.qualcomm.com>
	<AANLkTin9fSw5DdqdgCEvtdtc83LFOeA7t0OAUugVmRFD@mail.gmail.com>
	<20110125102652.GB11507@n2100.arm.linux.org.uk>
	<bb0c3855a121603232d022b4062752a6@mail.gmail.com>
Message-ID: <AANLkTinQf+psOnb_r38PdOzRMArcxOdKkQgO3g_3SCGS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Santosh,

On Tue, Jan 25, 2011 at 5:16 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
[...]

> The code above won't give major details of how the monitor mode is
> implemented. ?But as Russell said, it's pretty much vendor specific.
>
> On OMAP, We have standard API interfaces to enter into monitor
> world. One of the parameter denotes the kind of service, is
> requested.

Sorry if following are very naive.
What should be the attributes of a monitor implementation.
- Should it be un-modifiable.
- Does it run in normal (non-secure) mode ?
- Who programs the monitor (and its vector addresses) ?
- Would monitor intend to provide fixed services and how does it
decides that the request for a particular service is valid enough to
enter secure world ?
- Are monitors debuggable ?

thanks in advance for any kind help.

-- 
regards
Shiraz Hashim
