From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 23 Nov 2016 10:23:03 -0800
Subject: [PATCH v2 1/5] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <5835DC2D.5080606@gmail.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-2-git-send-email-bgolaszewski@baylibre.com>
 <a309a738-7fa7-3aab-4457-f7d693e6b37f@ti.com> <5833A2DA.40701@gmail.com>
 <800171a8-2e2c-2afb-f96d-800a17eaa17a@ti.com> <58348CB8.7050304@gmail.com>
 <b668871c-2b54-0a2f-0d68-afaa50e17e63@ti.com> <5835DC2D.5080606@gmail.com>
Message-ID: <5835DE87.6060208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/16 10:13, Frank Rowand wrote:
> On 11/22/16 21:55, Sekhar Nori wrote:
>> On Tuesday 22 November 2016 11:51 PM, Frank Rowand wrote:
>>> Please note that the compatible property might contain several strings, not just
>>> a single string.
>>
>> So I guess the best thing to do is to use
>> of_property_read_string_index() and print the sting at index 0.
>>
>> Thanks,
>> Sekhar
> 
> If you want to print just one compatible value, you could use that method.
> 
> To give all of the information needed to understand the problem, the error
> message would need to include all of the strings contained in the compatible
> property and all of the .board values in the da8xx_ddrctl_board_confs[] array
> (currently only one entry, but coded to allow additional entries in the
> future).
> 
> It is hard to justify an error message that complex.
> 
> I would just print an error that no match was found.
> 
> -Frank

I just needed to read some more emails.  I see this approach was taken
in the "[PATCH v4 0/2] da8xx: fix section mismatch in new drivers"
series.

-Frank
