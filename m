From: rajatja@google.com (Rajat Jain)
Date: Fri, 7 Apr 2017 09:46:05 -0700
Subject: [PATCH V7 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
In-Reply-To: <da4ddb16-3d60-93e5-1b5e-ac7a759d3f23@codeaurora.org>
References: <1490880636-30542-1-git-send-email-okaya@codeaurora.org>
 <7c48ca8b-b834-3257-91dc-77e9d19def6c@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B28466761383@IRSMSX101.ger.corp.intel.com>
 <92EBB4272BF81E4089A7126EC1E7B2846676271D@IRSMSX101.ger.corp.intel.com>
 <951505b8-9580-7131-2f14-de92817190a7@codeaurora.org>
 <CACK8Z6FG7QHs1kQUoTJTcP3606+xBLFp9RUmLuv0m0X2mxH9XA@mail.gmail.com>
 <da4ddb16-3d60-93e5-1b5e-ac7a759d3f23@codeaurora.org>
Message-ID: <CACK8Z6EBECtU3rUEv0Zpdw7YUFpkbz3J30EkT8y2ptYQ_O8Lgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 6, 2017 at 5:34 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Hi Rajat,
>
> On 4/6/2017 1:10 PM, Rajat Jain wrote:
>> Thanks, The above commit specifically adds a comment to
>> pcie_aspm_check_latency(), because I wanted to leave a note
>> highlighting that potentially, we could add a more stringent check for
>> exit latency for L1SS. But that has nothing to do with how we are
>> configuring or enabling / disabling the L1 substates.
>
> I saw your name in two L1SS reviews. I wanted to pull you into the discussion
> as an L1SS expert. I didn't want to imply that there was something wrong
> with the review. Apologies for that.

No worries, and actually thanks for pulling me in. :-)

>
> Sinan
>
> --
> Sinan Kaya
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
