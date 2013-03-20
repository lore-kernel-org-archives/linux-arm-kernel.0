From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Mar 2013 19:50:19 -0600
Subject: [PATCH] ARM: tegra: fuse: add fuctions to read speedo id and
 process id
In-Reply-To: <1363743557.3573.50.camel@dahuang-vm>
References: <1363660405-10668-1-git-send-email-dahuang@nvidia.com>
 <5148A8D6.8000002@wwwdotorg.org> <1363743557.3573.50.camel@dahuang-vm>
Message-ID: <514915DB.8060206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 07:39 PM, Danny Huang wrote:
> On Wed, 2013-03-20 at 02:05 +0800, Stephen Warren wrote:
>> On 03/18/2013 08:33 PM, Danny Huang wrote:
>>> Add functions to read the speedo and process id of both cpu and soc.
>>> There might be some drivers need the information as well.
>>
>> What code wants to use these functions? It'd be best to submit this
>> patch with that code, so that something actually uses the functions, and
>> they don't look like dead code.
> 
> There are some developing drivers that are located in drivers folder
> needs those information.

Which drivers?

> I think that they can't include a header file in mach-tegra folder

True.
