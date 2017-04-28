From: jgross@suse.com (Juergen Gross)
Date: Fri, 28 Apr 2017 19:59:42 +0200
Subject: [PATCH 1/3 v2] xen: Export xen_reboot
In-Reply-To: <7396d142-98b0-9554-4cbd-477bb9e2f8e5@suse.com>
References: <20170424175839.5262-1-julien.grall@arm.com>
 <20170424175839.5262-2-julien.grall@arm.com>
 <41fd4caf-7554-7d54-6332-d227228a13ea@oracle.com>
 <7396d142-98b0-9554-4cbd-477bb9e2f8e5@suse.com>
Message-ID: <0432aba8-5f05-d445-15a8-34b43fe40d99@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/17 06:02, Juergen Gross wrote:
> On 24/04/17 20:21, Boris Ostrovsky wrote:
>> On 04/24/2017 01:58 PM, Julien Grall wrote:
>>> The helper xen_reboot will be called by the EFI code in a later patch.
>>>
>>> Note that the ARM version does not yet exist and will be added in a
>>> later patch too.
>>>
>>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>
>> I don't think these changes are worth a whole patch. They can be folded
>> into the third patch.
> 
> No, the 2nd patch needs this, too.
> 
> So:
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Julien, this patch no longer applies to the for-linus-4.12 branch of
xen/tip. Can you please rebase?


Juergen
