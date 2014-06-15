From: ming.lei@canonical.com (Ming Lei)
Date: Sun, 15 Jun 2014 21:00:31 +0800
Subject: [PATCH v1 0/2]ata: Fix the dma state machine lockup for APM
 X-Gene SoC
In-Reply-To: <CAOHikRD+e2VLj8cN0B_D67bVosMmOf0rU-zuxFNeA8OgoypQGw@mail.gmail.com>
References: <1402574362-24986-1-git-send-email-stripathi@apm.com>
 <CACVXFVMTfNtBe3FXNuo-UqzY5fx+CpGhSCBOspM9G6By8Oi4RA@mail.gmail.com>
 <CAOHikRD+e2VLj8cN0B_D67bVosMmOf0rU-zuxFNeA8OgoypQGw@mail.gmail.com>
Message-ID: <CACVXFVMCJ14KdKOTeidhE5_kMHNgbgz0axK+YB2i_c-iCNRruQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 7:03 PM, Suman Tripathi <stripathi@apm.com> wrote:
> Hi Ming,
>
> I also tested in our mustang board. It is working fine. Without this patch ,
> I was also facing issues. Can send me the entire log of failure ?

Please see the dmsg log from patched kernel in below link:

  http://pastebin.com/4XcnHyrV

Thanks,
--
Ming Lei
