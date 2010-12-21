From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 21 Dec 2010 11:52:35 +0900
Subject: [PATCH 00/17] Samsung: Enable Audio Devices
In-Reply-To: <019301cba0ae$24902050$6db060f0$%kim@samsung.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
	<019301cba0ae$24902050$6db060f0$%kim@samsung.com>
Message-ID: <AANLkTinQ9zVY+0SBhHFJMRD6TVjnThEAy1zMwT_eHj5-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 21, 2010 at 10:26 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Jassi Brar wrote:
>>
>> From: Jassi Brar <jassi.brar@samsung.com>
>>
>> Hi,
>> ? Next come patches that lay ground to enable audio devices on
>> various latest SMDKS like 6440, 6442, 6450, C110, V210, V310 and C210.
>> Actual enabing of these devices will be done by patchset to be sent to
>> ASoC tree.
>>
> Hi Jassi,
>
> To apply your patches happen following build error in my for-next.
>
> 'error: 'samsung_asoc_dma' undeclared here (not in a function)'
>
> How can prevent build error?

hmmm... your tree doesn't have the commit 'ARM: Samsung: Define common
audio-dma
device' that I submitted to Mark.
