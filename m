From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Tue, 14 Apr 2015 10:54:05 -0700
Subject: [PATCHv2 2/3] usb: ehci-platform: Use devm_of_phy_get_by_index
In-Reply-To: <Pine.LNX.4.44L0.1504141040340.1370-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1504141040340.1370-100000@iolanthe.rowland.org>
Message-ID: <552D543D.5060600@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My apologies Alan, I missed that comment I was indeed trying to avoid 
the 80 column rule. It looks like i will have to resend this patch, so i 
will reformat the code then. Thanks

On 15-04-14 07:41 AM, Alan Stern wrote:
> On Mon, 13 Apr 2015, Arun Ramamurthy wrote:
>
>> Getting phys by index instead of phy names so that we do
>> not have to create a naming scheme when multiple phys
>> are present
>>
>> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>
> You have not responded to the comments I posted earlier:
>
> 	http://marc.info/?l=linux-usb&m=142798455925594&w=2
>
> Alan Stern
>
