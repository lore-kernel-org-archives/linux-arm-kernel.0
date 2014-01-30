From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 30 Jan 2014 11:32:32 +0530
Subject: [PATCH v2 0/2] drivers/media: Add controls for Horizontal and
 Vertical MV Search Range
In-Reply-To: <1391060563-27015-1-git-send-email-amit.grover@samsung.com>
References: <52E0ED10.2020901@samsung.com>
 <1391060563-27015-1-git-send-email-amit.grover@samsung.com>
Message-ID: <CAK9yfHzMk=NyC942z6mGFm6M--AZ7Tkq8q__MfvBGOnNrJ5vyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

On 30 January 2014 11:12, Amit Grover <amit.grover@samsung.com> wrote:
> Based on 'master' branch of Linux-next.

Kamil's tree [1] would be more current most of the times for this driver.

[1] git://linuxtv.org/kdebski/media.git


> This is v2 version for the patch:
> s5p-mfc: Add Horizontal and Vertical search range for Video Macro Blocks
> (https://lkml.org/lkml/2013/12/30/83)
>
> Changes from v1:
> 1) Splitted the patch into v4l2 and mfc driver patches.
> 2) Incorporated review comments of v1
>
> Amit Grover (2):
>   drivers/media: v4l2: Add settings for Horizontal and Vertical MV
>     Search Range
>   drivers/media: s5p-mfc: Add Horizontal and Vertical MV Search Range

nit: media changes use the following title format:
[media] v4l2: Add settings for Horizontal and Vertical MV Search Range
[media] s5p-mfc: Add Horizontal and Vertical MV Search Range



-- 
With warm regards,
Sachin
