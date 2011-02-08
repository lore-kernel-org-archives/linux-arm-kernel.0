From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Tue, 08 Feb 2011 15:38:21 +0900
Subject: [PATCH v4] dw_mmc: Add Synopsys DesignWare mmc host driver.
In-Reply-To: <AANLkTi=SEXYk9B6N6RGmLKAx_QF6sybgHMVVpEo8mcp8@mail.gmail.com>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
	<20101208115510.GD10998@console-pimps.org>
	<AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
	<AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
	<20101209064751.GA21128@void.printf.net>
	<AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
	<20101209160157.GA28586@void.printf.net>
	<AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com>
	<20101211192320.GA24430@void.printf.net>
	<AANLkTik7cMwgwXR1zK44HXC+1YtzpU3_zW2GUjcBMi8X@mail.gmail.com>
	<4D354752.3030401@samsung.com>
	<AANLkTi=SEXYk9B6N6RGmLKAx_QF6sybgHMVVpEo8mcp8@mail.gmail.com>
Message-ID: <4D50E4DD.4030500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will..

I need your help for your code..

In dw_mmc.h, exist some function pointer..

int *get_ro(u32 slot_id);
int *get_cd(u32 slot_id);
...

Just only need slot_id??
If i need the "struct dw_mci", could i append the parameter?

Will Newton wrote:
> On Tue, Jan 18, 2011 at 7:54 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Will.
>>
>> I have some question...i'm testing dw_mmc in our environment.
>> but i didn't understand pdata->init(?)...what initialize in there?
> 
> In most of our platforms init is empty so I guess it would be fine to
> change that code to ignore a null init pointer. An example of one of
> the things we do use the init function for is to switch pins to GPIO
> to handle card detect.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
