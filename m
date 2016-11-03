From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu, 3 Nov 2016 14:58:51 +0100
Subject: [PATCH 0/3] fix ohci phy name
In-Reply-To: <d72af1ff-52f1-09ea-ee22-110c163d52f8@ti.com>
References: <20161102124435.31777-1-ahaslam@baylibre.com>
 <CAKXjFTPiL6K8g2KuFrq9rKJpViVaGPuBDBFSKk9bjqjY3Zd5Rg@mail.gmail.com>
 <d72af1ff-52f1-09ea-ee22-110c163d52f8@ti.com>
Message-ID: <CAKXjFTNVXnytVhiZxXCrkeoLBBh=hYJZP3BNBZPJ-BHAUt=UAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 3, 2016 at 1:00 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Thursday 03 November 2016 01:54 PM, Axel Haslam wrote:
>> Hi Sekhar, David,
>>
>> It might make sense to have this patch series,
>> squashed into a single patch, would you agree,
>> or do you prefer it as is: one-per-subsystem?
>
> Patches in the current form are okay. Some coordination is required in
> getting them merged though. I am happy to take the driver patches
> through ARM-SoC with ack from respective maintainers.
>
> I will need to carry the platform patch through my tree because it
> conflicts with other changes I have already queued.
>
> That said, I am unable to review 3/3 since I am unable to find its baseline.
>

ok, ill send v2 fixing Davids comments on the commit messages
and referencing the missing patch that is queued on usb-next.

-Axel
> Thanks,
> Sekhar
