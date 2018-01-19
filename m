From: kieran.bingham@ideasonboard.com (Kieran Bingham)
Date: Fri, 19 Jan 2018 10:50:12 +0000
Subject: [PATCH 0/2] Add R8A77970/Eagle I2C support
In-Reply-To: <20171120102407.v7pqrv7e4zmpwmdb@verge.net.au>
References: <20171116210629.732112911@cogentembedded.com>
 <20171120102407.v7pqrv7e4zmpwmdb@verge.net.au>
Message-ID: <f08b6a05-4da0-eddc-3a16-67f505cfd8f5@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On 20/11/17 10:24, Simon Horman wrote:
> On Fri, Nov 17, 2017 at 12:06:29AM +0300, Sergei Shtylyov wrote:
>> Hello!
>>
>> Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
>> 'renesas-devel-20171113-v4.14' tag. We're adding the R8A77970 I2C nodes
>> and then describing the PCA9654 I/O expander connected to the I2C0 bus.
>> These patches depend on the R8A77970/Eagle PFC suport patchset in order
>> to apply/compile.
> 
> Given the dependency above I have marked these patches as deferred.
> Please repost or otherwise ping me once the dependency has been
> included in an RC release.

And here too - My Eagle patches are dependant upon the I2C support on Eagle-V3M.

Is this blocking issue resolved?
(I think it is based on my ability to apply the patches cleanly to
renesas-drivers-2018-01-09-v4.15-rc7)

--
Regards

Kieran
